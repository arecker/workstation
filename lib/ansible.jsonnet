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

local Dotfiles() = [
  {
    command: '{{ playbook_dir }}/scripts/register-dotfiles',
    register: 'register_dotfiles',
  },
  Directory(path='{{ item.dir }}') {
    with_items: '{{ register_dotfiles.stdout | from_json }}',
  },
  FileSymlink(src='{{ item.src }}', dst='{{ item.dst }}') {
    with_items: '{{ register_dotfiles.stdout | from_json }}',
  },
];

{
  Directory:: Directory,
  Dotfiles:: Dotfiles,
  FileCopy:: FileCopy,
  FileSymlink:: FileSymlink,
  Playbook:: Playbook,
}
