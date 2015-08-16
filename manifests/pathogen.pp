# pathogen.pp
define puppet_vim_env::pathogen (
  String $homedir,
  String $owner,
  String $colorscheme,
  String $puppetlint_opts
) {

  $autoloaddir = "${homedir}/.vim/autoload"

  file { $autoloaddir:
    ensure  => directory,
    owner   => $owner,
    require => File[ "${homedir}/.vim" ],
  }

  file { "${autoloaddir}/pathogen.vim":
    ensure => file,
    owner  => $owner,
    source => 'puppet:///modules/puppet_vim_env/pathogen.vim',
  }

  $epp_params = {
    'colorscheme'     => $colorscheme,
    'puppetlint_opts' => $puppetlint_opts,
  }

  file { "${homedir}/.vimrc":
    ensure  => file,
    owner   => $owner,
    content => epp('puppet_vim_env/vimrc.epp', $epp_params),
  }

}
