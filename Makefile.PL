use strict;
use warnings;
use inc::Module::Install;

name 'App-Env';

all_from 'lib/App/Env.pm';
license 'gpl3';

build_requires 'Test::More';

requires 'Getopt::Long' => 2.24;
requires 'Scalar::Util';
requires 'Params::Validate';
requires 'Env::Path';
requires 'Pod::Usage';
requires 'File::Temp';

install_script 'bin/appexec';

auto_install;

WriteAll;
