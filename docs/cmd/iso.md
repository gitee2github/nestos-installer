---
parent: Command line reference
nav_order: 4
---

# nestos-installer iso
{: .no_toc }

1. TOC
{:toc}

# nestos-installer iso customize

```
Customize a NestOS live ISO image

USAGE:
    nestos-installer iso customize [OPTIONS] <ISO>

ARGS:
    <ISO>
            ISO image

OPTIONS:
        --dest-ignition <path>
            Ignition config fragment for dest sys

            Automatically run installer and merge the specified Ignition config into the config
            for the destination system.

        --dest-device <path>
            Install destination device

            Automatically run installer, installing to the specified destination device.  The
            resulting boot media will overwrite the destination device without confirmation.

        --dest-console <spec>
            Kernel and bootloader console for dest
            Automatically run installer, configuring the specified kernel and bootloader
            console for the destination system.  The argument uses the same syntax as the
            parameter to the "console=" kernel argument.

        --dest-karg-append <arg>
            Destination kernel argument to append

            Automatically run installer, adding the specified kernel argument for every boot of
            the destination system.

        --dest-karg-delete <arg>
            Destination kernel argument to delete

            Automatically run installer, deleting the specified kernel argument for every boot
            of the destination system.

        --network-keyfile <path>
            NetworkManager keyfile for live & dest

            Configure networking using the specified NetworkManager keyfile. Network settings
            will be applied in the live environment, including when Ignition is run.  If
            installer is enabled via additional options, network settings will also be applied
            in the destination system, including when Ignition is run.

        --network-nmstate <path>
            Nmstate file for live & dest
            Configure networking using NetworkManager keyfiles generated from the specified
            Nmstate files. Network settings will be applied in the live environment, including
            when Ignition is run.  If installer is enabled via additional options, network
            settings will also be applied in the destination system, including when Ignition is
            run.
            
        --ignition-ca <path>
            Ignition PEM CA bundle for live & dest

            Specify additional TLS certificate authorities to be trusted by Ignition, in PEM
            format.  Authorities will be trusted by Ignition in the live environment and, if
            installer is enabled via additional options, in the destination system.

        --pre-install <path>
            Script to run before installation

            If installer is run at boot, run this script before installation. If the script
            fails, the live environment will stop at an emergency shell.

        --post-install <path>
            Script to run after installation

            If installer is run at boot, run this script after installation. If the script
            fails, the live environment will stop at an emergency shell.

        --installer-config <path>
            Installer config file

            Automatically run nestos-installer and apply the specified installer config file.
            Config files are applied in the order that they are specified.

        --live-ignition <path>
            Ignition config fragment for live env

            Merge the specified Ignition config into the config for the live environment.

        --live-karg-append <arg>
            Live kernel argument to append

            Kernel argument to append to boots of the live environment.

        --live-karg-delete <arg>
            Live kernel argument to delete

            Kernel argument to delete from boots of the live environment.

        --live-karg-replace <k=o=n>
            Live kernel argument to replace

            Kernel argument to replace for boots of the live environment, in the form
            key=old=new.  For a default argument "a=b", specifying "--live-karg-replace a=b=c"
            will produce the argument "a=c".

    -f, --force
            Overwrite existing customizations

    -o, --output <path>
            Write ISO to a new output file

    -h, --help
            Print help information
```

# nestos-installer iso ignition embed

```
Embed an Ignition config in an ISO image

USAGE:
    nestos-installer iso ignition embed [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -f, --force                   Overwrite an existing Ignition config
    -i, --ignition-file <path>    Ignition config to embed [default: stdin]
    -o, --output <path>           Write ISO to a new output file
    -h, --help                    Print help information
```

# nestos-installer iso ignition show

```
Show the embedded Ignition config from an ISO image

USAGE:
    nestos-installer iso ignition show <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -h, --help    Print help information
```

# nestos-installer iso ignition remove

```
Remove an existing embedded Ignition config from an ISO image

USAGE:
    nestos-installer iso ignition remove [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -o, --output <path>    Write ISO to a new output file
    -h, --help             Print help information
```

# nestos-installer iso network embed

```
Embed network settings in an ISO image

USAGE:
    nestos-installer iso network embed [OPTIONS] --keyfile <path> <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -k, --keyfile <path>    NetworkManager keyfile to embed
    -f, --force             Overwrite existing network settings
    -o, --output <path>     Write ISO to a new output file
    -h, --help              Print help information
```

# nestos-installer iso network extract

```
Extract embedded network settings from an ISO image

USAGE:
    nestos-installer iso network extract [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -C, --directory <path>    Extract to directory instead of stdout
    -h, --help                Print help information
```

# nestos-installer iso network remove

```
Remove existing network settings from an ISO image

USAGE:
    nestos-installer iso network remove [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -o, --output <path>    Write ISO to a new output file
    -h, --help             Print help information
```

# nestos-installer iso kargs modify

```
Modify kernel args in an ISO image

USAGE:
    nestos-installer iso kargs modify [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -a, --append <KARG>                   Kernel argument to append
    -d, --delete <KARG>                   Kernel argument to delete
    -r, --replace <KARG=OLDVAL=NEWVAL>    Kernel argument to replace
    -o, --output <PATH>                   Write ISO to a new output file
    -h, --help                            Print help information
```

# nestos-installer iso kargs reset

```
Reset kernel args in an ISO image to defaults

USAGE:
    nestos-installer iso kargs reset [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -o, --output <PATH>    Write ISO to a new output file
    -h, --help             Print help information
```

# nestos-installer iso kargs show

```
Show kernel args from an ISO image

USAGE:
    nestos-installer iso kargs show [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -d, --default    Show default kernel args
    -h, --help       Print help information
```

# nestos-installer iso extract pxe

```
Extract PXE files from an ISO image

USAGE:
    nestos-installer iso extract pxe [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -o, --output-dir <PATH>    Output directory [default: .]
    -h, --help                 Print help information
```

# nestos-installer iso extract minimal-iso

```
Extract a minimal ISO from a NestOS live ISO image

USAGE:
    nestos-installer iso extract minimal-iso [OPTIONS] <ISO> [OUTPUT_ISO]

ARGS:
    <ISO>           ISO image
    <OUTPUT_ISO>    Minimal ISO output file [default: -]

OPTIONS:
        --output-rootfs <PATH>    Extract rootfs image as well
        --rootfs-url <URL>        Inject rootfs URL karg into minimal ISO
    -h, --help                    Print help information
```

# nestos-installer iso reset

```
Restore a NestOS live ISO image to default settings

USAGE:
    nestos-installer iso reset [OPTIONS] <ISO>

ARGS:
    <ISO>    ISO image

OPTIONS:
    -o, --output <path>    Write ISO to a new output file
    -h, --help             Print help information
```
