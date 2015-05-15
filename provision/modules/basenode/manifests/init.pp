###
#Vagrant User is hard coded, need to move it to hiera
###
class basenode {
  $packages=["screen","git-core","curl","python-pip"]
  package {$packages:  ensure => latest,}
  exec { "Enabling Autocomplete for aws command":
	command => '/bin/echo "complete -C /usr/local/bin/aws_completer aws" >> /etc/profile',
	unless => '/bin/grep aws /etc/profile'
  }
  package {'awscli': ensure => latest, provider => pip,}
    file { "/root/.screenrc":
      ensure => "file",
      owner => "root",
      group => "root",
      require => Package["screen"],
      source => "puppet:///modules/basenode/screenrc"
    }
  class { 'vim' : 
    opt_misc => ['hlsearch','showcmd','showmatch','ignorecase','smartcase','incsearch','autowrite','hidden','number','tabstop=4'],
  }
#This is for my own purpose
  exec { "moving_old_puppet_dir":
	command => '/etc/init.d/puppetmaster stop && rm -rf /etc/puppet && ln -s /opt/data/puppet /etc/puppet && /etc/init.d/puppetmaster start',
	path    => "/usr/bin/:/bin/",
	unless  => "test ! -f /etc/puppet",
    user => 'root'
  }
}
