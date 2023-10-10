local a = import 'lib/ansible.jsonnet';

local tasks = [
  // re-generate dotfiles
  a.Dotfiles(),

  // setup ssh keys
  a.FileCopy('id_rsa', '~/.ssh/id_rsa', mode='0400'),
  a.FileCopy('id_rsa.pub', '~/.ssh/id_rsa.pub'),

  // setup passwords
  a.Clone(name='arecker/password-store', dst='~/.password-store'),

  // emacs
  a.Clone(name='arecker/emacs.d', dst='~/.emacs.d'),

  // python
  a.Clone(name='pyenv/pyenv', dst='~/.pyenv'),

  // ruby
  a.Clone(name='rbenv/rbenv', dst='~/.rbenv'),
  a.Directory('~/.rbenv/plugins'),
  a.Clone(name='rbenv/ruby-build', dst='~/.rbenv/.plugins/ruby-build'),

  // go
  a.Clone(name='go-nv/goenv', dst='~/.goenv'),

  // terraform
  a.Clone(name='tfutils/tfenv', dst='~/.tfenv'),

  // nodejs
  a.Clone(name='nodenv/nodenv', dst='~/.nodenv'),
];

[
  a.Playbook(tasks=tasks),
]
