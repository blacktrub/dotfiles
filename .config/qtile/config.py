# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import logging
import os
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.widget import base

from libqtile.log_utils import logger

logger.setLevel(logging.ERROR)

stream_mode = False


class TextBasedIntervalWidget(base.InLoopPollText):
    defaults = [
        ("update_interval", 1.0, "Update interval for the clock"),
    ]

    def __init__(self, width=bar.CALCULATED, **config):
        base.InLoopPollText.__init__(
            self, default_text=self.poll(), width=width, **config
        )
        self.add_defaults(self.defaults)

    def poll(self):
        raise NotImplemented()


class CurrentKeyboardLayout(TextBasedIntervalWidget):
    def poll(self):
        return f'{os.popen("xkb-switch").read().strip()}'


class PamixerVolume(TextBasedIntervalWidget):
    def poll(self):
        return f'{os.popen("pamixer --get-volume-human").read().strip()}'


class WarpCli:
    cli_command: str = "warp-cli"

    def run(self, command: str) -> bytes:
        proccess = subprocess.run([self.cli_command, command], capture_output=True)
        return proccess.stdout

    def is_connected(self) -> bool:
        # stdout=b'Status update: Connected\nSuccess\n'
        status = self.run("status").decode().lower()
        return "disconnected" not in status

    def connect(self) -> None:
        self.run("connect")

    def disconnect(self) -> None:
        self.run("disconnect")

    def switch(self) -> None:
        if self.is_connected():
            self.disconnect()
        else:
            self.connect()


@lazy.function
def lazy_vpn_switch(qtile) -> None:
    warp_cli.switch()


class VPNStatus(TextBasedIntervalWidget):
    def poll(self):
        if warp_cli.is_connected():
            return "| VPN"
        return ""


warp_cli = WarpCli()

mod = "mod4"
# terminal = guess_terminal()
terminal = "alacritty"
tmim = f"{terminal} -e tmux new -As vim"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # TODO: disabled becuase I use this key to swtich keyboard layouts
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod, "shift"],
        "s",
        lazy.spawn("scrot -e 'xclip -selection clipboard -t image/png -i $f' -z"),
        desc="Take screenshot",
    ),
    Key(
        [mod, "shift", "control"],
        "s",
        lazy.spawn("scrot -e 'xclip -selection clipboard -t image/png -i $f' -z -s"),
        desc="Take screenshot",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(
        [mod],
        "r",
        lazy.spawn("rofi -show run"),
        desc="Spawn a command using a prompt widget",
    ),
    # Run terminal
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "a", lazy.spawn(tmim), desc="Launch vim"),
    # Switch keyboard layout
    Key([mod], "space", lazy.spawn("xkb-switch -n"), desc="Switch keyboard layout"),
    Key(
        [mod, "control"],
        "v",
        lazy_vpn_switch,
        desc="Enable/disable VPN",
    ),
    # Sound hotkeys
    # Key([], 'XF86AudioRaiseVolume', lazy.spawn('pulseaudio-ctl up 5')),
    # Key([], 'XF86AudioLowerVolume', lazy.spawn('pulseaudio-ctl down 5')),
    # Key([], 'XF86AudioMute', lazy.spawn('pulseaudio-ctl set 1')),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
]

groups = [Group(i, label="·") for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=2),
    # layout.Stack(
    #     num_stacks=2,
    #     border_focus_stack=['#ffffff', '#ffffff'],
    #     border_focus='#ffffff',
    #     border_width=1,
    #     grow_amount=2,
    #     insert_position=1,
    # ),
    layout.Columns(
        border_focus_stack=["#ffffff", "#ffffff"],
        border_focus="#ffffff",
        # border_width=1,
        grow_amount=2,
        margin=3,
        insert_position=2,
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Hack",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

if not stream_mode:
    screens = [
        Screen(
            wallpaper="~/pic/pattern4k.jpg",
            top=bar.Bar(
                [
                    widget.CurrentLayout(),
                    # widget.Image(filename="~/pic/arch-logo.png"),
                    widget.GroupBox(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    widget.WindowName(),
                    widget.Chord(
                        chords_colors={
                            "launch": ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),
                    # widget.TextBox("default config", name="default"),
                    # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                    widget.Systray(),
                    # widget.Sep(linewidth=0, padding=6),
                    VPNStatus(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    CurrentKeyboardLayout(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    PamixerVolume(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    # widget.QuickExit(),
                ],
                24,
                # 0,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            ),
        ),
    ]
else:
    fake_screens = [
        Screen(
            wallpaper="~/pic/mosaic.jpg",
            top=bar.Bar(
                [
                    widget.CurrentLayout(),
                    # widget.Image(filename="~/pic/arch-logo.png"),
                    widget.GroupBox(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    widget.WindowName(),
                    widget.Chord(
                        chords_colors={
                            "launch": ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),
                    # widget.TextBox("default config", name="default"),
                    # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                    widget.Systray(),
                    VPNStatus(),
                    # widget.Sep(linewidth=0, padding=6),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    CurrentKeyboardLayout(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    PamixerVolume(),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                    widget.TextBox(
                        text="|", fontsize=12, foreground=["#f8f8f2", "#f8f8f2"]
                    ),
                    # widget.QuickExit(),
                ],
                24,
                # 0,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            ),
            width=1920,
            height=1080,
            x=960,
            y=540,
        ),
        Screen(
            bottom=bar.Bar(
                [
                    widget.Prompt(),
                    widget.Sep(),
                    widget.WindowName(),
                    widget.Sep(),
                    widget.Systray(),
                    widget.Sep(),
                    widget.Clock(format="%H:%M:%S %d.%m.%Y"),
                ],
                24,
                background="#555555",
            ),
            x=0,
            y=0,
            width=960,
            height=2160,
        ),
        Screen(
            bottom=bar.Bar(
                [
                    widget.Prompt(),
                    widget.Sep(),
                    widget.WindowName(),
                    widget.Sep(),
                    widget.Systray(),
                    widget.Sep(),
                    widget.Clock(format="%H:%M:%S %d.%m.%Y"),
                ],
                24,
                background="#555555",
            ),
            x=960 + 1920,
            y=0,
            width=960,
            height=2160,
        ),
    ]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="feh"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
