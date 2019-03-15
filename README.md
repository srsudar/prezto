# My Custom `prezto`

I maintain this separately from my other
[dotfiles](https://github.com/srsudar/dotfiles). For the most part, these
should be installed by by cloning this repo and following the "Installation"
section below. A few things to note, however, that I always mess up:
* Follow the instructions exactly. All of them, including launching `zsh` to
    begin.
    * **For real**. They are specific, and invariably I try to copy them and
        get a stupid naming convention wrong, like the annoying `prezto` to
        `.zprezto` directory name, and mess something up. Just copy them, with
        the exception pointed out below.
    * **Except**: clone my own repo, not sorin-ionescu's as shown in the clone
        URL. Depending on my terminal (iTerm2, Ubuntu's), `chsh` might not be
        enough, so you might also have to do whatever the terminal of choice
        requires.
* See the next section on machine-specific configuration.

## Machine-Specific Configuration

I have added a convention for machine-specific configuration that doesn't
exist, so far as I know, in the original Prezto project. Alongside the
`runcoms/` directory, I've added a `machine-specific/` directory. Config
specific to certain machines (e.g. `/usr/local/Cellar/` on a Mac) belongs in
files in that directory.

In order to source those files appropriately, I've also taken to assigning each
machine a name. E.g. my Macbook Air is `mbair`. The existence of a file
`~/.zshMachineFlag_machineName` indicates the current machine. Adding a line
like this to `runcoms/zshrc` ensures that we source the file appropriately:

```
if [[ -a ~/.zshMachineFlag_mbair ]]; then
  source "${ZDOTDIR:-$HOME}"/.zprezto/machine-specific/mbair_zshrc
fi
```

## Platform-Specific Configuration

Configuration that varies across platform (e.g. standard `ls` versions), is
configured in `.zprezto/machine-specific/<platform>_zshrc`, with platform named
according to the output of `uname -s` and converted to lower case. These files
are sourced before machine-specific files to try allow more specific overrides.

## Setting up Prezto

### First-time Setup

Here are the steps to set this up for the first time:
* Determine a machine name. For this example we'll say it's foo.
* If custom configuration is required, add it to `machine-specific/foo_zshrc`.
* Execute `touch ~/.zshMachineFlag_foo`.
* Add these lines to `runcoms/zshrc`:
```
if [[ -a ~/.zshMachineFlag_foo ]]; then
  source "${ZDOTDIR:-$HOME}"/.zprezto/machine-specific/mbair_foo
fi
```

### Repeat Setup
In this case we don't need to worry about editing the files. Just:
* `touch ~/.zshMachineFlag_foo`


## Selective `vcs_info`

`vcs_info` allows for integration of version control systems with your prompt.
This can be slow, however, depending on the options you're supporting.
`check-for-changes` in particular can be slow on big `git` repos like Chromium,
e.g. To get around this, I've added a function based on [this
method](https://github.com/johan/zsh/blob/master/Misc/vcs_info-examples#L88-L102)
that allows selective disabling of `check-for-changes` on a machine-specific
basis.

In order to indicate that you do not want `check-for-changes` to be true, add
an element to the `ZSHMS_VCSINFO_NO_CHECK_CHANGES` array with the absolute path
to the directory you want ignored. See `machine-specific/mbair_zshrc` for an
example. This variable is then looked for in the prompt command to selectively
enable or disable `check-for-changes`.


> Old README below.

Prezto — Instantly Awesome Zsh
==============================

Prezto is the configuration framework for [Zsh][1]; it enriches the command line
interface environment with sane defaults, aliases, functions, auto completion,
and prompt themes.

Installation
------------

Prezto will work with any recent release of Zsh, but the minimum required
version is 4.3.11.

  1. Launch Zsh:

     ```console
     zsh
     ```

  2. Clone the repository:

     ```console
     git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
     ```

  3. Create a new Zsh configuration by copying the Zsh configuration files
     provided:

     ```sh
     setopt EXTENDED_GLOB
     for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
       ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
     done
     ```

     Note: If you already have any of the given configuration files, `ln` will
     cause error. In simple cases you can load prezto by adding the line
     `source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"` to the bottom of your
     `.zshrc` and keep the rest of your Zsh configuration intact. For more
     complicated setups, it is recommended that you back up your original
     configs and replace them with the provided prezto runcoms.

  4. Set Zsh as your default shell:

     ```console
     chsh -s /bin/zsh
     ```

  5. Open a new Zsh terminal window or tab.

### Troubleshooting

If you are not able to find certain commands after switching to *Prezto*,
modify the `PATH` variable in *~/.zprofile* then open a new Zsh terminal
window or tab.

Updating
--------

Run `zprezto-update` to automatically check if there is an update to zprezto.
If there are no file conflicts, zprezto and its submodules will be
automatically updated. If there are conflicts you will instructed to go into
the `$ZPREZTODIR` directory and resolve them yourself.

To pull the latest changes and update submodules manually:

```console
cd $ZPREZTODIR
git pull
git submodule update --init --recursive
```

Usage
-----

Prezto has many features disabled by default. Read the source code and
accompanying README files to learn of what is available.

### Modules

  1. Browse */modules* to see what is available.
  2. Load the modules you need in *~/.zpreztorc* then open a new Zsh terminal
     window or tab.

### Themes

  1. For a list of themes, type `prompt -l`.
  2. To preview a theme, type `prompt -p name`.
  3. Load the theme you like in *~/.zpreztorc* then open a new Zsh terminal
     window or tab.

     ![sorin theme][2]
     Note that the 'git' module may be required for special symbols to appear,
     such as those on the right of the above image. Add `'git'` to the `pmodule`
     list (under `zstyle ':prezto:load' pmodule \` in your *~/.zpreztorc*) to
     enable this module.

### External Modules

  1. By default modules will be loaded from */modules* and */contrib*.
  2. Additional module directories can be added to the
     `:prezto:load:pmodule-dirs` setting in *~/.zpreztorc*.

     Note that module names need to be unique or they will cause an error when
     loading.

     ```sh
     zstyle ':prezto:load' pmodule-dirs $HOME/.zprezto-contrib
     ```

Customization
-------------

The project is managed via [Git][3]. It is highly recommended that you fork this
project; so, that you can commit your changes and push them to [GitHub][4] to
not lose them. If you do not know how to use Git, follow this [tutorial][5] and
bookmark this [reference][6].

Resources
---------

The [Zsh Reference Card][7] and the [zsh-lovers][8] man page are indispensable.

License
-------

This project is licensed under the MIT License.

[1]: http://www.zsh.org
[2]: http://i.imgur.com/nrGV6pg.png "sorin theme"
[3]: http://git-scm.com
[4]: https://github.com
[5]: http://gitimmersion.com
[6]: https://git.github.io/git-reference/
[7]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[8]: http://grml.org/zsh/zsh-lovers.html
