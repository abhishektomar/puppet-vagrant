## Copying .bashrc file to all users home directory

class basenode::ps ($title,){
          file { "/home/$title/.screenrc":
                owner => $title,
                group => $title,
                source => "puppet:///basenode/screenrc",
               } 
	 }
