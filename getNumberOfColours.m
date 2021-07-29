function n = getNumberOfColours()
%GETNUMBEROFCOLOURS Get number of rows/colours for in lookup-table.
%   This function gets an input from the user for the maximum number
%   of colours in the colour map, and checks if it's a valid value, if not,
%   ask again, and do so until a value between 1 and 256 is entered.

% Prompt user for input.
numberOfColours = input('Enter maximum number of colours for the lookup table: ');

while 1 % Do while no correct value is entered for numberOfColours.
    if (numberOfColours > 0) && (numberOfColours <= 256) % Limits for the lookup table.
        n = numberOfColours; % Accept user input in 'n'.
        return
    else % Else, wrong input and ask for value again.
        numberOfColours = input('Enter number in range 1-256: ');
    end % End if value is accepted for 'n'.
end