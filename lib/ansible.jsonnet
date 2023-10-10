local Playbook(tasks=[]) = {
  hosts: 'localhost',
  connection: 'local',
  tasks: tasks,
};

local Directory(path) = {
  file: {
    path: path,
    state: 'directory',
  },
};

local FileCopy(name, dst, mode='0644') = {
  'ansible.builtin.copy': {
    src: '{{ playbook_dir }}/files/' + name,
    dest: dst,
    mode: mode,
  },
};

local FileSymlink(src, dst) = {
  'ansible.builtin.file': {
    src: src,
    dest: dst,
    state: 'link',
  },
};

local Dotfiles() = {
  command: '{{ playbook_dir }}/scripts/generate-dotfiles',
  register: 'generate_dotfiles',
  changed_when: 'generate_dotfiles.stdout == "changed"',
};

{
  Directory:: Directory,
  Dotfiles:: Dotfiles,
  FileCopy:: FileCopy,
  FileSymlink:: FileSymlink,
  Playbook:: Playbook,
}
