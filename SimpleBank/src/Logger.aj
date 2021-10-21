
import java.time.LocalDateTime;
import static java.nio.file.StandardOpenOption.*;
import java.nio.file.*;
import java.io.*;

public aspect Logger {

	Path filePath = Paths.get("src\\log.txt");
	void esribirTransacciones(String tipoTran) {

		LocalDateTime lc = LocalDateTime.now();
		String s = lc + " tipo transaccion: " + tipoTran + "\n";
		byte data[] = s.getBytes();

		try (OutputStream out = new BufferedOutputStream(Files.newOutputStream(filePath, CREATE, APPEND))) {
			out.write(data, 0, data.length);
		} catch (IOException x) {
			System.err.println(x);
		}
	}

	pointcut successUser() : call(* create*(..) );

	after() : successUser() {
		// Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario
		System.out.println("**** User created ****");
	}

	// Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con
	// los tipos de transacciones realizadas.
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