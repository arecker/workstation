local a = import 'lib/ansible.jsonnet';

local tasks = [
  // re-generate dotfiles
  a.Dotfiles(),

  // setup ssh keys
  a.FileCopy('id_rsa', '~/.ssh/id_rsa', mode='0400'),
  a.FileCopy('id_rsa.pub', '~/.ssh/id_rsa.pub'),
];

[
  a.Playbook(tasks=tasks),
]
