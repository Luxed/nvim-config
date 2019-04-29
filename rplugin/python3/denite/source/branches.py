import subprocess

from denite.base.source import Base
from denite.kind.command import Kind as Command


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'branches'
        self.kind = Kind(vim)

    def gather_candidates(self, context):
        branches = []

        branches_string = subprocess.run(["git", "branch",
                                          "--sort=-committerdate",
                                          "--format=\"%(refname:lstrip=2)\""],
                                         capture_output=True).stdout

        for branch in branches_string.splitlines():
            branch_name = branch.decode('utf-8').replace('"', '')
            branches.append({
                    'word': branch_name,
                    'action__command': f'silent !git checkout {branch_name}'
                    })

        return branches


class Kind(Command):
    def __init__(self, vim):
        super().__init__(vim)
        self.vim = vim
        self.name = 'branches'

    def action_preview(self, context):
        target = context['targets'][0]
        self.vim.command(target["action_test"])

    # def action_preview(self, context):
        # target = context['targets'][0]
        # self.vim.command(f'echom {target["word"]}')
