#!perl 

use Test::More qw( no_plan ); #Random initial string...
use lib qw( lib ../lib ../../lib  ); #Just in case we are testing it in-place

use YAML qw(LoadFile);
use Log::YAMLLogger;

my $l = new Log::YAMLLogger { id => 'id' };

$l->add_timestamp;
my @data = ( ['foo'], { bar=> 'bar' });
for my $d (@data ) {
  $l->log( $d );
}
$l->log( { zipi => 'zape'},1);
$l->close;
like( $l->name, qr/id/, 'Name OK');
my @result = LoadFile( $l->name );
for my $r (@result[1..2] ) {
  is_deeply($r, shift @data, 'Added OK' );
}

