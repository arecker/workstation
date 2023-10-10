local Playbook(tasks=[]) = {
  hosts: 'localhost',
  connection: 'local',
  tasks: tasks,
};

local Directory(path) = {
  name: std.format('directory: %s', path),
  file: {
    path: path,
    state: 'directory',
  },
};

local FileCopy(name, dst, mode='0644') = {
  name: std.format('copy: %s -> %s', [name, dst]),
  'ansible.builtin.copy': {
    src: '{{ playbook_dir }}/files/' + name,
    dest: dst,
    mode: mode,
  },
};

local FileSymlink(src, dst) = {
  name: std.format('link: %s -> %s', [src, dst]),
  'ansible.builtin.file': {
    src: src,
    dest: dst,
    state: 'link',
  },
};

local Dotfiles() = {
  name: 'command: ./script/generate-dotfiles',
  command: '{{ playbook_dir }}/scripts/generate-dotfiles',
  register: 'generate_dotfiles',
  changed_when: 'generate_dotfiles.stdout == "changed"',
};

local Clone(name='', dst) = {
  name: std.format('clone: %s -> %s', [name, dst]),
  'ansible.builtin.git': {
    repo: std.format('git@github.com:%s.git', name),
    dest: dst,
  },
};

{
  Clone:: Clone,
  Directory:: Directory,
  Dotfiles:: Dotfiles,
  FileCopy:: FileCopy,
  FileSymlink:: FileSymlink,
  Playbook:: Playbook,
}
