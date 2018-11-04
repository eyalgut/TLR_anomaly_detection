function mydate=getDate(st)
    mydate=st;
    %{
    mydate=strsplit(st,'_');
    mydate=mydate(2);
    mydate=strsplit(char(mydate),'.');
    mydate=mydate(1); % return something like this 20150715000000%
    %}
end


