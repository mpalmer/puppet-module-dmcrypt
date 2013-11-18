A fairly trivial module to manage dm-crypt volumes.

To create a "`dmcrypt` device", which is basically a configuration
specifying various bits of useful info about the device to help manage it,
use the `dmcrypt::device` type.  See the documentation for that type for
more information on how to use it.

Once that's been done and Puppet has run, you will have a `dmcrypt` program
available, which you'll need to run yourself to make things happen (Puppet
can't run it because it needs passphrases).  This program can be run in the
following ways (in each case `<name>` is the namevar of the
`dmcrypt::device` resource you wish to work on):

* `dmcrypt init <name>` -- This needs to be run once, before you wish to use
  the device.  It will prompt you for a passphrase (which will be used to
  secure the volume), initialize the block device as a LUKS volume, and
  that's it.

* `dmcrypt open <name>` -- This command will prompt for the passphrase for
  the device and "open" it.  This involves creating a new block device node,
  `/dev/mapper/<name>-decrypted`, which you can then use as a normal block
  device.  In addition:
  
  * If you have specified `vg_name` to `dmcrypt::device`, `dmcrypt`
    will activate that volume group.
  
  * If you specified any `mountpoints` to `dmcrypt::device`, `dmcrypt` will
    attempt to mount them if the block device you specified exists.

* `dmcrypt close <name>` -- If you wish to secure the volume from prying
  eyes, you can run this to unmount all the filesystems and close off the
  encrypted volume.  Before it can be used again, you'll need to re-run
  `dmcrypt open <name>`, or manually open it.
