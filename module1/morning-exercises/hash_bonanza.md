Write a method that takes a hash and returns the depth of the deepest value.

hash_bonanza = { :key_1 => { :key_2 => { :key_3_a => { :key_4 => "found me!" }, :key_3_b => "not quite" } } }

hash_depth(hash_bonanza)
# => 4
