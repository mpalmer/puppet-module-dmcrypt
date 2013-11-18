class dmcrypt::core {
	package { "cryptsetup-bin": }
	
	file {
		"/etc/dmcrypt":
			ensure  => directory,
			mode    => 0755,
			owner   => "root",
			group   => "root";
		"/etc/dmcrypt/devices":
			ensure  => directory,
			mode    => 0750,
			owner   => "root",
			group   => "root",
			recurse => true,
			purge   => true;
		"/usr/local/sbin/dmcrypt":
			ensure  => file,
			source  => "puppet:///modules/dmcrypt/usr/local/sbin/dmcrypt",
			mode    => 0755,
			owner   => "root",
			group   => "root";
	}
}
	
