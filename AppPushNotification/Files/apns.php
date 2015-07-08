<?php 

$apnsHost = 'gateway.sandbox.push.apple.com'; 
$apnsPort = '2195'; 
$sslPem = 'apns-dev.pem';
$passPhrase = '1234';

$apnsConnection; 
$serviceConnection;

$token = $_POST['token']; 
$alerta = $_POST['alerta']; 
$badge = $_POST['badge']; 
$som = $_POST['som']; 

$message = '{"aps":{"alert":"'.$alerta.'","badge":'.$badge.',"sound":"'.$som.'"}}'; 

$message = str_replace('\\','',$message); 

echo "<p>message " . $message . "<p>";

$streamContext = stream_context_create(); 
stream_context_set_option($streamContext, 'ssl', 'local_cert', $sslPem); 
stream_context_set_option($streamContext, 'ssl', 'passphrase', $passPhrase);

$apnsConnection = stream_socket_client('ssl://'.$apnsHost.':'.$apnsPort, $error, $errorString, 60, STREAM_CLIENT_CONNECT, $streamContext);

$apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', $token)) . chr(0) . chr(strlen($message)) . $message;

$retorno = fwrite($apnsConnection, $apnsMessage); 

if ($apnsConnection == false || $error || $errorString) 
	echo "Failed to connect {$error} {$errorString}\n"; 
else 
	echo "Enviado com sucesso"; 
	
	
echo "<p>Retorno " . $retorno;

fclose($apnsConnection); 

?>