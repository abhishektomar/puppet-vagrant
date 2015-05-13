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
  class { 'ohmyzsh': }
  ohmyzsh::install { ['root', 'vagrant']: }
  ohmyzsh::theme { ['root', 'vagrant']: theme => 'robbyrussell' }
  ohmyzsh::plugins { 'acme': plugins => 'git github' }
  ohmyzsh::upgrade { ['root', 'vagrant']: }
}
