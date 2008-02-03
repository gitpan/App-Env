use strict;
use warnings;
use inc::Module::Install;

name 'App-Env';

all_from 'lib/App/Env.pm';
license 'gpl3';

build_requires 'Test::More';
build_requires 'Env::Path';

requires 'Getopt::Long' => 2.24;
requires 'Scalar::Util';
requires 'Params::Validate';
requires 'Pod::Usage';
requires 'File::Temp';
requires 'File::Basename';

install_script 'bin/appexec';

auto_install;

WriteAll;
