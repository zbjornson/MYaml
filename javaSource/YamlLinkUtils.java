import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.SafeConstructor;

import com.wolfram.jlink.KernelLink;
import com.wolfram.jlink.MathLinkException;
import com.wolfram.jlink.StdLink;

@SuppressWarnings("unchecked")
public class YamlLinkUtils {
	public static void Parse(String filename) {
		InputStream input = null;
		KernelLink link = null;
		try {
			link = StdLink.getLink();
			link.beginManual();
			
			Yaml yaml = new Yaml(new SafeConstructor());
			input = new FileInputStream(new File(filename));
			Object result = yaml.load(input);
			Deserialize(link, result);
		} catch (Exception e) {
			try {
				link.message("Import::general", e.getMessage());
				link.abandonEvaluation();
				link.putSymbol("$Failed");
				e.printStackTrace(System.out);
			} catch (Exception e2) {
				e2.printStackTrace(System.out);
			}
		} finally {
			try {
				if (input != null) input.close();
			} catch (Exception e) {
				e.printStackTrace(System.out);
			}
		}
	}

	private static void Deserialize(KernelLink link, Object value) throws MathLinkException {
		if (value instanceof Collection) {
			link.putFunction("List", ((Collection<Object>)value).size());
			for (Object entry : (Iterable<Object>)value) {
				Deserialize(link, entry);
			}

		} else if (value instanceof Map) {
			link.putFunction("List", ((Map<Object, Object>)value).size());
			for (Map.Entry<Object, Object> entry : ((Map<Object, Object>)value).entrySet()) {
				link.putFunction("Rule", 2);
				Deserialize(link, entry.getKey());
				Deserialize(link, entry.getValue());
			}
			
		} else if (value instanceof Date) {
			Calendar cal = Calendar.getInstance();
			cal.setTime((Date)value);
			link.putFunction("DateObject", 1);
			link.putFunction("List", 6);
			link.put(cal.get(Calendar.YEAR));
			link.put(cal.get(Calendar.MONTH) + 1);
			link.put(cal.get(Calendar.DAY_OF_MONTH));
			link.put(cal.get(Calendar.HOUR_OF_DAY));
			link.put(cal.get(Calendar.MINUTE));
			link.put(cal.get(Calendar.SECOND));
		} else {
			link.put(value);
		}
	}
}
