package Upgrade;

$ENV{DBIC_NO_VERSION_CHECK} = 1;

use Class::Unload;
use Data::Dumper;
use Test::Roo::Role;
use Test::Most;
use DBIx::Class::Schema::Loader qw/make_schema_at/;

requires 'connect_info';

has database => (
    is => 'lazy',
    clearer => 1,
);

after each_test => sub {
    my $self = shift;
    #Class::Unload->unload('TestVersion::Schema');
    #Class::Unload->unload('TestVersion::Schema::Result::Bar');
    #Class::Unload->unload('TestVersion::Schema::Result::Foo');
    #Class::Unload->unload('TestVersion::Schema::Result::Tree');
    Class::Unload->unload('Test::Schema');
    #Class::Unload->unload('Test::Schema::Result::Bar');
    #Class::Unload->unload('Test::Schema::Result::Foo');
    #Class::Unload->unload('Test::Schema::Result::Tree');
};

test 'deploy 0.001' => sub {
    my $self = shift;

    no warnings 'redefine';
    local *DBIx::Class::Schema::schema_version = sub { '0.001' };

    my $schema = TestVersion::Schema->connect($self->connect_info);

    lives_ok( sub { $schema->deploy }, "deploy schema" );

    cmp_ok( $schema->schema_version, 'eq', '0.001', "Check schema version" );
    cmp_ok( $schema->get_db_version, 'eq', '0.001', "Check db version" );

    cmp_deeply( [ $schema->sources ], [qw(Foo)], "class Foo only" );

    my $foo = $schema->source('Foo');
    cmp_deeply( [ sort $foo->columns ], [qw(foos_id height)],
        "Foo columns OK" )
      || diag "got: "
      . join( " ", $foo->columns );
};

test 'upgrade to 0.002' => sub {
    my $self = shift;

    no warnings 'redefine';
    local *DBIx::Class::Schema::schema_version = sub { '0.002' };

    my $schema = TestVersion::Schema->connect($self->connect_info);

    cmp_ok( $schema->schema_version, 'eq', '0.002', "Check schema version" );
    cmp_ok( $schema->get_db_version, 'eq', '0.001', "Check db version" );

    # let's upgrade!

    lives_ok(
        sub { $schema->upgrade },
        "Upgrade " . $schema->get_db_version . " to " . $schema->schema_version
    );

    cmp_ok( $schema->get_db_version, 'eq', '0.002',
        "Check db version post upgrade" );
};

test 'test 0.002' => sub {
    my $self = shift;

    make_schema_at(
        'Test::Schema',
        {
            exclude => qr/dbix_class_schema_versions/,
            naming  => 'current',
        },
        [ $self->connect_info ],
    );

    my $schema = 'Test::Schema';

    cmp_bag( [ $schema->sources ], [qw(Bar Foo)], "Foo and Bar" );

    # columns
    my $foo = $schema->source('Foo');
    cmp_bag(
        [ Test::Schema::Result::Foo->columns ],
        [qw(age bars_id foos_id width)],
        "Foo columns OK"
    );
    my $bar = $schema->source('Bar');
    cmp_bag(
        [ $bar->columns ],
        [qw(age bars_id weight)],
        "Bar columns OK"
    );
};

test 'upgrade to 0.003' => sub {
    my $self = shift;

    no warnings 'redefine';
    local *DBIx::Class::Schema::schema_version = sub { '0.003' };

    my $schema = TestVersion::Schema->connect($self->connect_info);

    cmp_ok( $schema->schema_version, 'eq', '0.003', "Check schema version" );
    cmp_ok( $schema->get_db_version, 'eq', '0.002', "Check db version" );

    # let's upgrade!

    lives_ok(
        sub { $schema->upgrade },
        "Upgrade " . $schema->get_db_version . " to " . $schema->schema_version
    );

    cmp_ok( $schema->get_db_version, 'eq', '0.003',
        "Check db version post upgrade" );
};

test 'test 0.003' => sub {
    my $self = shift;

    make_schema_at(
        'Test::Schema',
        {
            exclude => qr/dbix_class_schema_versions/,
            naming  => 'current',
        },
        [ $self->connect_info ],
    );

    my $schema = 'Test::Schema';

    cmp_bag( [ $schema->sources ], [qw(Bar Tree)], "Tree and Bar" )
      or diag Dumper( $schema->sources );

    # columns
    my $tree = $schema->source('Tree');
    cmp_bag(
        [ Test::Schema::Result::Tree->columns ],
        [qw(age bars_id trees_id width)],
        "Tree columns OK"
    );
    my $bar = $schema->source('Bar');
    cmp_bag(
        [ $bar->columns ],
        [qw(age bars_id height weight)],
        "Bar columns OK"
    );
};

test 'upgrade to 0.3' => sub {
    my $self = shift;

    no warnings 'redefine';
    local *DBIx::Class::Schema::schema_version = sub { '0.3' };

    my $schema = TestVersion::Schema->connect($self->connect_info);

    cmp_ok( $schema->schema_version, 'eq', '0.3',   "Check schema version" );
    cmp_ok( $schema->get_db_version, 'eq', '0.003', "Check db version" );

    # let's upgrade!

    lives_ok(
        sub { $schema->upgrade },
        "Upgrade " . $schema->get_db_version . " to " . $schema->schema_version
    );

    cmp_ok( $schema->get_db_version, 'eq', '0.3',
        "Check db version post upgrade" );
};

test 'test 0.3' => sub {
    my $self = shift;

    make_schema_at(
        'Test::Schema',
        {
            exclude => qr/dbix_class_schema_versions/,
            naming  => 'current',
        },
        [ $self->connect_info ],
    );

    my $schema = 'Test::Schema';

    cmp_bag( [ $schema->sources ], [qw(Tree Bar)], "Tree and Bar" )
      or diag Dumper( $schema->sources );

    # columns
    my $tree = $schema->source('Tree');
    cmp_bag(
        [ Test::Schema::Result::Tree->columns ],
        [qw(trees_id age bars_id width)],
        "Tree columns OK"
    );
    my $bar = $schema->source('Bar');
    cmp_bag(
        [ $bar->columns ],
        [qw(age bars_id height weight)],
        "Bar columns OK"
    );
};

test 'upgrade to 0.4' => sub {
    my $self = shift;

    no warnings 'redefine';
    local *DBIx::Class::Schema::schema_version = sub { '0.4' };

    my $schema = TestVersion::Schema->connect($self->connect_info);

    cmp_ok( $schema->schema_version, 'eq', '0.4', "Check schema version" );
    cmp_ok( $schema->get_db_version, 'eq', '0.3', "Check db version" );

    # let's upgrade!

    lives_ok(
        sub { $schema->upgrade },
        "Upgrade " . $schema->get_db_version . " to " . $schema->schema_version
    );

    cmp_ok( $schema->get_db_version, 'eq', '0.4',
        "Check db version post upgrade" );
};

test 'test 0.4' => sub {
    my $self = shift;

    make_schema_at(
        'Test::Schema',
        {
            exclude => qr/dbix_class_schema_versions/,
            naming  => 'current',
        },
        [ $self->connect_info ],
    );

    my $schema = 'Test::Schema';

    cmp_bag( [ $schema->sources ], [qw(Bar Tree)], "Tree and Bar" )
      or diag Dumper( $schema->sources );

    # columns
    my $tree = $schema->source('Tree');
    cmp_bag(
        [ Test::Schema::Result::Tree->columns ],
        [qw(age bars_id trees_id width)],
        "Tree columns OK"
    );
    my $bar = $schema->source('Bar');
    cmp_bag(
        [ $bar->columns ],
        [qw(age bars_id height)],
        "Bar columns OK"
    );
};

1;