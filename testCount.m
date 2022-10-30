clear;clc;

countHex = 'ab1e';

zeroPosition = '44bc';

count = hex2dec(countHex) - hex2dec(zeroPosition);
deg = count / 65536 * 360;

% deg = 65;
div = 256;
degPerCount = 1.8 / div;
c = round( deg / degPerCount);

cHex = dec2hex(c);