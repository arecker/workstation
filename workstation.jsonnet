local a = import 'lib/ansible.jsonnet';

local tasks = [

  // setup SSH
  a.Directory('~/.ssh'),
  a.FileCopy('ssh/id_rsa', '~/.ssh/id_rsa', mode='0400'),
  a.FileCopy('ssh/id_rsa.pub', '~/.ssh/id_rsa.pub'),
  a.FileSymlink('ssh/config', '~/.ssh/config'),

];

[
  a.Playbook(tasks=tasks),
]
