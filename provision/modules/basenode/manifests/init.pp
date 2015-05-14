###
#Vagrant User is hard coded, need to move it to hiera
###
class basenode {
  $packages=["screen","git-core","curl"]
  package {$packages:  ensure => latest,}
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
	onlyif  => "test ! -f /etc/puppet",
    user => 'root'
  }
}
