#!/usr/bin/python3

import os

class MemInfo():
    def __init__(self, file_path):
        self.info = self.load(file_path)

    def load(self, file_path):
        if not os.path.exists(file_path):
            return {}
        with open(file_path, 'r') as mem_info:
            return dict(
                    [line.strip().replace(':', '').split()[0:2]
                        for line in mem_info.readlines()]
                    )

            def is_loaded(self):
                if self.info:
                    return True
        else:
            return False

    def retrieve(self, target):
        return int(self.info[target])

    def get_mem_total(self):
        return self.retrieve('MemTotal')

    def get_mem_free(self):
        return self.retrieve('MemFree')

    def get_buffers(self):
        return self.retrieve('Buffers')

    def get_cached(self):
        return self.retrieve('Cached')

    def get_mem_used(self):
        return self.get_mem_total() \
                - self.get_mem_free() \
                - self.get_buffers() \
                - self.get_cached()

# size: kB
def convert(size, cnt):
    if size < 1024 ** (cnt+1):
        return f'{size / 1024 ** cnt:.3g}{units[cnt]}'
    return convert(size, cnt+1)

def main():
    mem_info = MemInfo('/proc/meminfo')
    if not mem_info.is_loaded():
        return
    try:
        used = mem_info.get_mem_used()
    except KeyError as err:
        return

    rate = used / mem_info.get_mem_total()
    try:
        print(f'{convert(used, 0)} : {rate:.1%}')
    except IndexError as err:
        return


units = ['kB', 'MB', 'GB', 'TB']

if __name__ == '__main__':
    main()
