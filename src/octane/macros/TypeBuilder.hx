package octane.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.FieldType;
import haxe.macro.TypeTools;
import octane.types.DynamicExt;
#end

/**
 * ...
 */
class TypeBuilder
{
	#if macro
	
	private static var _definitions:DynamicExt;
	
	/**
	 * Updates types to those defined in the definitions.json.
	 * @return
	 */
	macro public static function build():Array<Field>
	{
		var fields:Array<Field> = Context.getBuildFields();
		
		var definitions:DynamicExt = null;
		
		if (_definitions == null)
		{
			definitions = CompileTime.parseJsonFile("definitions.json");
			_definitions = definitions;
		}
		else
		{
			definitions = _definitions;
		}
		
		for (field in fields)
		{
			var metaParam:String = getMetaParam(field);
			
			if (metaParam != null)
			{
				if (definitions.exists(metaParam))
				{
					var definitionName:String = definitions.get(metaParam);
					//trace(metaParam+" -> "+definitionName);
					field.kind = FieldType.FVar(TypeTools.toComplexType(Context.getModule(definitionName)[0]), macro $v{null});
				}
			}
		}
		
		return fields;
	}
	
	/**
	 * Gets the inject metadata value for a field.
	 * @param	field
	 * @return
	 */
	static function getMetaParam(field:Field):String
	{
		for (meta in field.meta)
		{
			for (param in meta.params)
			{
				switch(param.expr)
				{
					case EConst(s):
						switch(s)
						{
							case CString(s):
								return s;
							
							default: {}
						}
					
					default: {}
				}
			}
		}
		
		return null;
	}
	
	#end
}