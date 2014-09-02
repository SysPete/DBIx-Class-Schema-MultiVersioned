package TestCandy::Schema::Result::Bar;
use TestCandy::Schema::Candy;

since '0.002';

primary_column bars_id => {
    data_type         => 'integer',
    is_auto_increment => 1,
};

column age => {
    data_type   => "integer",
    is_nullable => 1,
    versioned   => {
        since   => '0.003',
        changes => {
            '0.004' => {
                data_type     => "integer",
                is_nullable   => 0,
                default_value => 18
            },
        }
    }
};

column height => {
    data_type   => "integer",
    is_nullable => 1,
    versioned   => { since => '0.003' }
};

column weight => {
    data_type   => "integer",
    is_nullable => 1,
    versioned   => { until => '0.4' }
};

has_many
  trees => 'TestCandy::Schema::Result::Tree',
  'bars_id', { versioned => { since => '0.003' } };

1;
