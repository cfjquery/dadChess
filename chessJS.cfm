<script type='text/javascript'>
  $(document).ready(function(){
      //GLOBAL VARS
      var posTop = <cfoutput>#posTop#</cfoutput>;
      var posLeft = <cfoutput>#posLeft#</cfoutput>;
      var posSq = <cfoutput>#posSq#</cfoutput>;
      var xPosFrom = 0;
      var yPosFrom = 0;
      var xPosTo = 0;
      var yPosTo = 0;
      var pieceMoved = '';         //i.e rk nk bk k q bq nq rq - RK NK BK K Q BQ NQ RQ
      var pMoved = '';             //i.e r n b k q p - R N B K Q P
      var pFrom = '';
      var aryValidMoves = new Array();
      var aryBoard = new Array(8);
      for(var i=0;i<=7;i++)
      {
        aryBoard[i]=new Array(8);
      }
      //DRAG HANDLER SETTINGS
      $('.d').draggable({
        grid:[posSq,posSq],
        containment:'#chessboard',
        cursor:'move',
        start:handleDragStart,
        stop:handleDragStop
      });
     //DRAG START HANDLER - RECORD POSITION OF PIECE THAT WAS MOVED
      function handleDragStart(event,ui){
        var oxPos = parseInt(ui.offset.left);
        var oyPos = parseInt(ui.offset.top);
        pieceMoved = getPieceMoved(this.id);          
        xPosFrom = parseInt(((oxPos - posLeft)/posSq));
        yPosFrom = parseInt(((oyPos -posTop)/posSq));
      }
      //DRAG STOP HANDLER - RECORD THE NEW POSITION OF PIECE AND UPDATE THE BOARD POSITIONS
      function handleDragStop(event,ui){
        var oxPos = parseInt(ui.offset.left);
        var oyPos = parseInt(ui.offset.top);
        xPosTo = parseInt(((oxPos - posLeft)/posSq));
        yPosTo = parseInt(((oyPos - posTop)/posSq));
        updateBoardPositions();
      }
      //GET THE PIECE THAT WAS MOVED - COMPLETE AND SINGULAR
      function getPieceMoved(piece){
        //CALCULATE WHETHER PIECE IS 1 OR 2 CHARS LONG
        var pLength = 1;
        if(piece.length == 6){
          pLength = 2;
        }
        pieceMoved = piece.substr(4,pLength);
        pMoved = piece.substr(4,1);
        pFrom = piece.substr(1,2);
        $('#pieceMoved').val(piece);
        $('#pMoved').val(pMoved);
        $('#pFrom').val(pFrom);
      }
      //UPDATE BOARD POSITIONS
      function updateBoardPositions(){
        //SET THE FROM POSITION TO EMPTY (I.E. 1)
        aryBoard[yPosFrom][xPosFrom] ='x' + yPosFrom + xPosFrom + 'x' + '1';
        //SET THE TO POSITION TO THE PIECE JUST MOVED
        aryBoard[yPosTo][xPosTo] = $('#pieceMoved').val();
        //CREATE THE FEN FOR THE BOARD
        createFen();
      }
      //CREATE THE FORSYTH NOTATION STRING TO MAP THE BOARD LAYOUT AFTER LAST MOVE
      function createFen(){
        var strPiece = '';
        var piece = '';
        var fen = '';
        for(var i=0;i<=7;i++){
          for(var j=0;j<=7;j++){
            var strPiece = aryBoard[i][j];
            piece = strPiece.substr(4,1);
            fen = fen + piece;
          }
          if(i != 7){
              fen = fen + '/';
          }
        }
        //REPLACE STRINGS OF ONES WITH CORRECT NUMERAL
        for(var i=8;i>=2;i--){
          for(var j=0;j<=7;j++){
            var strOnes = '11111111'.substr(0,i);
            fen = fen.replace(strOnes,i);
          }
        }
        $('#fen').val(fen);
      }
      //INITIALISE THE BOARD
      function initBoard(){
        aryBoard[0][0]='x00xrq';
        aryBoard[0][1]='x01xnq';
        aryBoard[0][2]='x02xbq';
        aryBoard[0][3]='x03xq';
        aryBoard[0][4]='x04xk';
        aryBoard[0][5]='x05xbk';
        aryBoard[0][6]='x06xnk';
        aryBoard[0][7]='x07xrk';
        for(var j=0;j<=7;j++)
        {
          aryBoard[1][j]='x1'+j+'xp';
        }
        for(var i=2;i<=5;i++)
        {
          for(var j=0;j<=7;j++)
          {
            aryBoard[i][j]='x'+i+j+'x1';
          }
        }
        for(var j=0;j<=7;j++)
        {
          aryBoard[6][j]='x6'+j+'xP';
        }
        aryBoard[7][0]='x70xRQ';
        aryBoard[7][1]='x71xNQ';
        aryBoard[7][2]='x72xBQ';
        aryBoard[7][3]='x73xQ';
        aryBoard[7][4]='x74xK';
        aryBoard[7][5]='x75xBK';
        aryBoard[7][6]='x76xNK';
        aryBoard[7][7]='x77xRK';
      }
      initBoard();
  });  
</script>