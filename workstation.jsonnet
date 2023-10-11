local Directory(path, mode=null) = {
  name: std.format('directory: %s', path),
  file: std.prune({
    path: path,
    state: 'directory',
    mode: mode,
  }),
};

local FileCopy(name, dst, mode='0644') = {
  name: std.format('copy: %s -> %s', [name, dst]),
  'ansible.builtin.copy': {
    src: '{{ playbook_dir }}/files/' + name,
    dest: dst,
    mode: mode,
  },
};

local Clone(name='', dst) = {
  name: std.format('clone: %s -> %s', [name, dst]),
  'ansible.builtin.git': {
    repo: std.format('git@github.com:%s.git', name),
    dest: dst,
  },
};

local Dotfiles() = {
  name: 'command: ./script/generate-dotfiles',
  'ansible.builtin.command': '{{ playbook_dir }}/scripts/generate-dotfiles',
  register: 'generate_dotfiles',
  changed_when: 'generate_dotfiles.stdout == "changed"',
};

local KeyImport(name='') = (
  local keyPath = std.format('{{ playbook_dir }}/files/%s', name);
  local stdin = std.format('{{ lookup("ansible.builtin.file", "%s") }}', keyPath);

  {
    name: std.format('gpg: %s', name),
    'ansible.builtin.command': 'gpg --import',
    args: {
      stdin: stdin,
    },
    register: 'key_import',
    changed_when: '"imported: 1" in key_import.stderr',
  }
);

local InstallQuicklisp() = {
  name: 'command: ./script/install-quicklisp',
  'ansible.builtin.command': '{{ playbook_dir }}/scripts/install-quicklisp',
  args: {
    creates: '~/.quicklisp',
  },
};

local tasks = [
  // dotfiles
  Dotfiles(),

  // gpg
  Directory('~/.gnupg', mode='0700'),
  KeyImport(name='gpg/public.gpg.asc'),
  KeyImport(name='gpg/private.gpg.asc'),

  // setup ssh keys
  FileCopy('ssh/id_rsa', '~/.ssh/id_rsa', mode='0400'),
  FileCopy('ssh/id_rsa.pub', '~/.ssh/id_rsa.pub'),

  // setup passwords
  Clone(name='arecker/password-store', dst='~/.password-store'),

  // emacs
  Clone(name='arecker/emacs.d', dst='~/.emacs.d'),

  // python
  Clone(name='pyenv/pyenv', dst='~/.pyenv'),

  // ruby
  Clone(name='rbenv/rbenv', dst='~/.rbenv'),
  Directory('~/.rbenv/plugins'),
  Clone(name='rbenv/ruby-build', dst='~/.rbenv/.plugins/ruby-build'),

  // go
  Clone(name='go-nv/goenv', dst='~/.goenv'),

  // terraform
  Clone(name='tfutils/tfenv', dst='~/.tfenv'),

  // nodejs
  Clone(name='nodenv/nodenv', dst='~/.nodenv'),

  // common lisp
  InstallQuicklisp(),
];

[
  {
    hosts: 'localhost',
    connection: 'local',
    tasks: tasks,
  },
]
