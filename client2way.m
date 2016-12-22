
function message = client( number_of_retries)

    import java.net.Socket
    import java.io.*

	
    if (nargin < 1)
        number_of_retries = -1; % set to -1 for infinite
    end
    
    retry        = 0;
    input_socket = [];
    inputChars = char (1024);
    charsRead = 0;
    
    message      = [];
    port = 5000;
    host = '192.168.1.10';

    while true

        retry = retry + 1;
        if ((number_of_retries > 0) && (retry > number_of_retries))
            fprintf(1, 'Too many retries\n');
            break;
        end
%% connect to server
try
   
    sock = Socket(host,port);
    in = BufferedReader(InputStreamReader(sock.getInputStream));
    out = PrintWriter(sock.getOutputStream,true);
catch ME
    error(ME.identifier, 'Connection Error: %s', ME.message)
end

%% get response from server
str = in.readLine();
disp(['Server says: ' char(str)])

%% get input from user, and send to server via client
sb1 = char('geia server,');
sb2 = char('sou epistrefw thn wra sou :P , ');
sb3 = char(str);

userInput = strcat(sb1,sb2,sb3);

out.println(userInput);

%% cleanup
out.close();
in.close();
sock.close();

        end
    end