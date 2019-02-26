
%A = sort(round(10*rand(5,3)),2)
A
B = sort([9, 8, 2])

ismember(A,B,'rows')

if sum(ismember(A,B,'rows'))>0
    'yes'
else
    'no'
end