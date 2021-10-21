
import java.time.LocalDateTime;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

public aspect Logger {
   
	    void esribirTransacciones(String tipoTran) {
	    	LocalDateTime lc = LocalDateTime.now();
	    	String data = " "+lc + " tipo transaccion= " + tipoTran+" ,";
	    	try {
	    	 	Files.writeString(Paths.get("log.txt"), data, StandardOpenOption.CREATE,StandardOpenOption.APPEND); 		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    	
	    }

	    pointcut successUser() : call(* create*(..) );
	    after() : successUser() {
	    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
	    	System.out.println("**** User created ****");
	    }

	    
	    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
	    pointcut successTransaction() : execution(* moneyMakeTransaction(..) );
	    after() : successTransaction() {
	    	System.out.println("**** Transaccion realizada ****");
	    	esribirTransacciones("transaccion");
	    }
	    
	    pointcut successWithdrawal() : execution(* moneyWithdrawal(..) );
	    after() : successWithdrawal() {
	    	System.out.println("**** Dinero retirado ****");
	    	esribirTransacciones("dinero retirado");
	    		    	
	    }
	
	
}