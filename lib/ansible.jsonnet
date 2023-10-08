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

local FileCopy(src, dst, mode='0644') = {
  'ansible.builtin.copy': {
    src: 'files/' + src,
    dest: dst,
    mode: mode,
  },
};

local FileSymlink(src, dst) = {
  'ansible.builtin.file': {
    src: '{{playbook_dir}}/files/' + src,
    dest: dst,
    state: 'link',
  },
};

{
  Directory:: Directory,
  FileCopy:: FileCopy,
  FileSymlink:: FileSymlink,
  Playbook:: Playbook,
}
