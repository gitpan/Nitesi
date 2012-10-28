#! perl
#
# Tests for Nitesi Account Manager

use strict;
use warnings;

use Test::More tests => 5;
use Nitesi::Account::Manager;

my ($account, $ret);

# without account providers
$account = Nitesi::Account::Manager->new;
isa_ok($account, 'Nitesi::Account::Manager');
$ret = $account->login(username => 'racke', password => 'nevairbe');
ok ($ret == 0);

# with sample account provider
$account = Nitesi::Account::Manager->new(provider_sub => \&providers);
isa_ok($account, 'Nitesi::Account::Manager');
$ret = $account->login(username => 'racke', password => 'nevairbe');
ok ($ret == 1);
$ret = $account->login(username => 'racke', password => 'neviarbe');
ok ($ret == 0);

sub providers {
    return [['Nitesi::Account::Provider::Test',
            users => {racke => {password => 'nevairbe'}}]];
}
