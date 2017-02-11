package octane.types;

import haxe.ds.Vector;
import msignal.Signal;
import octane.display.Sprite;
import octane.types.NativeTypes.NativeTexture;

/**
 * ...
 */
class Grid
{
	public var sigShifted:Signal1<GridCell>;
	
	public var params:GridParameters;
	
	private var _grid:Vector<Vector<GridCell>>;
	
	private var _numPaddedCols:Int;
	private var _numPaddedRows:Int;
	
	/**
	 * Constructor.
	 */
	public function new(params:GridParameters) 
	{
		this.params = params;
		
		sigShifted = new Signal1<GridCell>();
		
		build(params);
	}
	
	/**
	 * Destructor.
	 */
	public function destroy():Void 
	{
		
	}
	
	
	
	// API
	//============================================================================================================
	
	public function getAbsolute(col:Int, row:Int):GridCell
	{
		return _grid[col][row];
	}
	
	public function get(col:Int, row:Int):GridCell
	{
		return _grid[col + params.paddingX][row + params.paddingY];
	}
	
	public function getAll():Array<GridCell>
	{
		var output:Array<GridCell> = [];
		
		for (x in 0..._numPaddedCols)
		{
			for (y in 0..._numPaddedRows)
			{
				output.push(_grid[x][y]);
			}
		}
		
		return output;
	}
	
	public function getCol(index:Int):Array<GridCell>
	{
		var output:Array<GridCell> = [];
		
		for (y in 0..._numPaddedRows)
		{
			output.push(_grid[index + params.paddingX][y]);
		}
		
		return output;
	}
	
	public function getRow(index:Int):Array<GridCell>
	{
		var output:Array<GridCell> = [];
		
		for (x in 0..._numPaddedCols)
		{
			trace(_grid[x][index + params.paddingY] != null);
			output.push(_grid[x][index + params.paddingY]);
		}
		
		return output;
	}
	
	public function shiftColDown(col:Int):Void
	{
		col += params.paddingX;
		
		var lastRow:GridCell = _grid[col][_numPaddedRows - 1];
		
		for (y in 1..._numPaddedRows)
		{
			_grid[col][_numPaddedRows - y] = _grid[col][_numPaddedRows - y - 1];
		}
		
		lastRow.sprite.y -= params.cellHeight * _numPaddedRows;
		lastRow.offset.y -= _numPaddedRows;
		_grid[col][0] = lastRow;
		
		resetPositions();
		
		sigShifted.dispatch(lastRow);
	}
	
	public function shiftRowRight(row:Int):Void
	{
		row += params.paddingY;
		
		var lastCol:GridCell = _grid[_numPaddedCols - 1][row];
		
		for (x in 1..._numPaddedCols)
		{
			_grid[_numPaddedCols - x][row] = _grid[_numPaddedCols - x - 1][row];
		}
		
		lastCol.sprite.x -= params.cellWidth * _numPaddedCols;
		lastCol.offset.x -= _numPaddedCols;
		_grid[0][row] = lastCol;
		
		resetPositions();
	}
	
	public function shiftColUp(col:Int):Void
	{
		col += params.paddingX;
		
		var firstRow:GridCell = _grid[col][0];
		
		for (y in 0..._numPaddedRows - 1)
		{
			_grid[col][y] = _grid[col][y + 1];
		}
		
		firstRow.sprite.y += params.cellHeight * _numPaddedRows;
		firstRow.offset.y += _numPaddedRows;
		_grid[col][_numPaddedRows - 1] = firstRow;
		
		resetPositions();
	}
	
	public function shiftRowLeft(row:Int):Void
	{
		row += params.paddingY;
		
		var firstCol:GridCell = _grid[0][row];
		
		for (x in 0..._numPaddedCols - 1)
		{
			_grid[x][row] = _grid[x + 1][row];
		}
		
		firstCol.sprite.x += params.cellWidth * _numPaddedCols;
		firstCol.offset.x += _numPaddedCols;
		_grid[_numPaddedCols - 1][row] = firstCol;
		
		resetPositions();
	}
	
	public function resetSymbolPositions():Void
	{
		for (x in 0..._numPaddedCols)
		{
			for (y in 0..._numPaddedRows)
			{
				_grid[x][y].sprite.x = (x - params.paddingX) * (params.cellWidth  + params.spacingX);
				_grid[x][y].sprite.y = (y - params.paddingY) * (params.cellHeight + params.spacingY);
			}
		}
	}
	
	
	
	// PRIVATE
	//============================================================================================================
	
	private function build(params:GridParameters):Void
	{
		// Derive number of cols+rows with padding
		_numPaddedCols = params.numCols + (params.paddingX * 2);
		_numPaddedRows = params.numRows + (params.paddingY * 2);
		
		// Create grid
		_grid = new Vector<Vector<GridCell>>(_numPaddedCols);
		
		// Loop through grid
		for (x in 0..._numPaddedCols)
		{
			// Create column vector
			_grid[x] = new Vector<GridCell>(_numPaddedRows);
			
			// Loop through column rows
			for (y in 0..._numPaddedRows)
			{
				// Create cell
				var t:GridCell = { 
					name: "none",
					sprite: new Sprite(NativeTexture.EMPTY),
					position: { x: x - params.paddingX, y: y - params.paddingY }, 
					offset: { x: x - params.paddingX, y: y - params.paddingY }
				};
				
				_grid[x][y] = t;
			}
		}
	}
	
	private inline function resetPositions():Void
	{
		for (x in 0..._numPaddedCols)
		{
			for (y in 0..._numPaddedRows)
			{
				_grid[x][y].position.x = x - params.paddingX;
				_grid[x][y].position.y = y - params.paddingY;
			}
		}
	}
	
	
	
	// DEBUG
	//============================================================================================================
	
	public function printPositionsY():Void
	{
		var line:String = "\n";
		
		for (y in 0..._numPaddedRows)
		{
			line += y + ": ";
			
			for (x in 0..._numPaddedCols)
			{
				//trace(Reflect.getProperty(_grid[x][y], "position"));
				line += "[" + Reflect.getProperty(_grid[x][y], "position").x + "] ";
			}
			
			line += "\n";
		}
		
		trace(line);
	}
}


typedef GridParameters = 
{
	var numCols:Int;
	var numRows:Int;
	var cellWidth:Float;
	var cellHeight:Float;
	var paddingX:Int;
	var paddingY:Int;
	var spacingX:Float;
	var spacingY:Float;
}

typedef GridCell =
{
	public var sprite:Sprite;
	public var name:String;
	public var position:Position;
	public var offset:Position;
}