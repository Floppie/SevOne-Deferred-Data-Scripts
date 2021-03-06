-- Insert all the permutations of hash units and their conversions {{{
-- Hash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', '', 0, '', '', ''),
	('Kilohash', 'kHash', 1, 'Hash', '/', '1000'),
	('Megahash', 'MHash', 1, 'Hash', '/', '1000000'),
	('Gigahash', 'GHash', 1, 'Hash', '/', '1000000000');

-- Kilohash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', '', 1, 'Kilohash', '*', '1000'),
	('Kilohash', 'kHash', 0, '', '', ''),
	('Megahash', 'MHash', 1, 'Kilohash', '/', '1000'),
	('Gigahash', 'GHash', 1, 'Kilohash', '/', '1000000');

-- Megahash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', '', 1, 'Megahash', '*', '1000000'),
	('Kilohash', 'kHash', 1, 'Megahash', '*', '1000'),
	('Megahash', 'MHash', 0, '', '', ''),
	('Gigahash', 'GHash', 1, 'Megahash', '/', '1000000');

-- Gigahash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', '', 1, 'Gigahash', '*', '1000000000'),
	('Kilohash', 'kHash', 1, 'Gigahash', '*', '1000000'),
	('Megahash', 'MHash', 1, 'Gigahash', '*', '1000'),
	('Gigahash', 'GHash', 0, '', '', '');
-- }}}

-- Insert all the permutations of LTC units and their conversions {{{
-- LTC base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Litecoin', 'LTC', 0, '', '', ''),
	('Millilitecoin', 'mLTC', 1, 'Litecoin', '*', '1000'),
	('Microlitecoin', 'μLTC', 1, 'Litecoin', '*', '1000000');

-- mLTC base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Millilitecoin', 'mLTC', 0, '', '', ''),
	('Litecoin', 'LTC', 1, 'Millilitecoin', '/', '1000'),
	('Microlitecoin', 'μLTC', 1, 'Millilitecoin', '*', '1000');

-- μLTC base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Microlitecoin', 'μLTC', 0, '', '', ''),
	('Litecoin', 'LTC', 1, 'Microlitecoin', '/', '1000000'),
	('Millilitecoin', 'mLTC', 1, 'Microlitecoin', '/', '1000');
-- }}}
