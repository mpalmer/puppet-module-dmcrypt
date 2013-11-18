define dmcrypt::device($device,
                       $vg_name = undef,
                       $mountpoints = {}) {
	include dmcrypt::core

	$dmcrypt_device_name        = $name
	$dmcrypt_device_device      = $device
	$dmcrypt_device_vg_name     = $vg_name
	$dmcrypt_device_mountpoints = $mountpoints
	
	file { "/etc/dmcrypt/devices/${name}":
		content => template("dmcrypt/etc/dmcrypt/devices"),
		mode    => 0440,
		owner   => "root",
		group   => "root";
	}
}
                       
