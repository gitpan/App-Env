use strict;
use warnings;
use inc::Module::Install;

name 'App-Env';

perl_version '5.008000';
license 'gpl3';
all_from 'lib/App/Env.pm';

build_requires 'Test::More';
build_requires 'Test::Exception';

requires 'Getopt::Long' => 2.24;
requires 'Scalar::Util';
requires 'Params::Validate';
requires 'Pod::Usage';
requires 'File::Temp';
requires 'File::Basename';
requires 'Module::Find';
requires 'Env::Path';
requires 'File::Spec::Functions';
requires 'IPC::System::Simple';

install_script 'bin/appexec';

auto_install;

WriteAll;
