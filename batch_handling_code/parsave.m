function parsave(filename, structure, nameStructure) 
%This function saves structure of data at a given location
%Separation of this function with respect to for loops allows for
%parallellisation
%input: filename = location where structure is saved
%input: structure = structure of data to be saved
%input: nameStructure = name that will be given to the saved structure

S.(nameStructure)=structure;
save(filename,'-struct','S')
display(['saved ' filename])