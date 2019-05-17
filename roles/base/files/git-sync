#!/usr/bin/env python
import argparse
import datetime
import logging
import os
import sys


def get_logger(verbose=False):
    if verbose:
        level = logging.DEBUG
    else:
        level = logging.INFO

    logger = logging.getLogger('git-sync')
    logger.setLevel(level)
    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(level)
    formatter = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    return logger


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', '--verbose', action='store_true', help='print debug logs')
    parser.add_argument('-d', '--dir', '--directory', help='path to git repo')
    return parser.parse_args()


class ShellCommandFailed(Exception):
    pass


def shell(cmd, suppress=False):
    code = os.system(cmd)
    if not suppress and code != 0:
        raise ShellCommandFailed
    return code
    

def main():
    args = get_args()
    logger = get_logger(verbose=args.verbose)
    logger.debug('starting git-sync')

    logger.debug('validating git is installed')
    try:
        shell('which git')
    except ShellCommandFailed:
        logger.error('git is not installed!')
        sys.exit(1)

    path = os.path.abspath(args.dir)
    logger.debug('moving to %s', path)
    os.chdir(path)

    logger.info('checking for changes')
    if shell('git diff --exit-code', suppress=True) == 0:
        logger.info('no changes, exiting')
        sys.exit(0)

    logger.info('adding modifications')
    try:
        shell('git add -A')
    except ShellCommandFailed:
        logger.error('failed to add modifications!')
        sys.exit(1)

    logger.info('writing commit')
    message = 'git-commit-push: {}'.format(datetime.datetime.now())
    logger.debug('generated commit message: %s', message)
    try:
        shell('git commit -m "{}"'.format(message))
    except ShellCommandFailed:
        logger.error('failed write commit modifications!')
        sys.exit(1)

    logger.info('pushing commit')
    try:
        shell('git push')
    except ShellCommandFailed:
        logger.error('failed write push commit!')
        sys.exit(1)

    logger.info('finished!')


if __name__ == '__main__':
    main()
