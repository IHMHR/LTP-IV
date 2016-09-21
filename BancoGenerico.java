package banco;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;



public class Banco {
	
	public static Connection objCon;
	
	public static void abrirConexao(String classeDriver,String url, String usr, String senha) throws SQLException, ClassNotFoundException {

		Class.forName(classeDriver);
		objCon = DriverManager.getConnection(url, usr, senha);	
	
	}
	
	public static void fecharConexao() throws SQLException {
		objCon.close();
	}
	/**
	 * Quais as tabelas do Banco
	 * @return objeto ResulSet cada linha de dados com o nome de uma tabela
	 * @throws SQLException
	 */
	public static ResultSet listaTabelas() throws SQLException {
		DatabaseMetaData dbmd = objCon.getMetaData ( );
		return dbmd.getTables( null, "%" , "%" , new String[ ] {"TABLE"} );
	}
	/**
	 * Ler a descrição dos dados da resposta de um comando SELECT
	 * @param nome da tabela
	 * @return objeto ResultSetMetaData com a descrição dos dados da resposta
	 * @throws SQLException
	 */
	public static ResultSetMetaData dadosTabela(String nome) throws SQLException{
		String sql = "SELECT * FROM " + nome + " WHERE 1=2"; // resposta só com cabeçalho
		Statement objSQL = objCon.createStatement();
		ResultSet objResultSet = objSQL.executeQuery(sql);
		return objResultSet.getMetaData();
	}
	/**
	 * Consulta SELECT no Banco 
	 * @param sql comando SELECT
	 * @return objeto ResultSet com os dados da resposta
	 * @throws SQLException
	 */
	public static ResultSet consultaSQL(String sql) throws SQLException {
		Statement objSQL = objCon.createStatement();
		return objSQL.executeQuery(sql);
	}

}
