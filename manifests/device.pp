# Configure a `dmcrypt` "device" so that the `dmcrypt` command line tool can
# work on it.
#
# Parameters are:
#
# * `namevar`: The name of the device.  This is what you'll use to refer to
#   the device when running `dmcrypt` yourself, so best to keep it nice and
#   short).  You'll also get a device node called
#   `/dev/mapper/<name>-decrypted` when the device is "opened" by `dmcrypt
#   open`.
#
# * `device`: The underlying block device that holds the encrypted volume.
#
# * `vg_name`: An (optional) LVM volume group name to activate when opening
#   the encrypted volume.  This is necessary so that any LVs in the VG are
#   available for mounting or other manipulation after the VG is opened.
#
# * `mounts`: This is an optional hash of `blockdevice` => `mountpoint` entries,
#   which `dmcrypt` will attempt to mount after the encrypted volume is
#   opened, and unmount before it is closed.
#
define dmcrypt::device($device,
                       $vg_name = undef,
                       $mounts = {}) {
	include dmcrypt::core

	$dmcrypt_device_name    = $name
	$dmcrypt_device_device  = $device
	$dmcrypt_device_vg_name = $vg_name
	$dmcrypt_device_mounts  = $mounts
	
	file { "/etc/dmcrypt/devices/${name}":
		content => template("dmcrypt/etc/dmcrypt/devices"),
		mode    => 0440,
		owner   => "root",
		group   => "root";
	}
}
                       
