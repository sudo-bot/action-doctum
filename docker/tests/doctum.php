<?php

use Doctum\Doctum;
use Doctum\RemoteRepository\GitHubRemoteRepository;
use Symfony\Component\Finder\Finder;

$dir = realpath(__DIR__ . '/src');
$iterator = Finder::create()
    ->files()
    ->name('*.php')
    ->in($dir);

return new Doctum($iterator, [
    'title'                => 'GitHub action sudo-bot/action-doctum',
    'build_dir'            => '/tmp/doctum-build',
    'cache_dir'            => '/tmp/doctum-cache',
    'remote_repository'    => new GitHubRemoteRepository('sudo-bot/action-doctum', realpath($dir . '/../')),
]);
