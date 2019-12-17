import java.util.HashMap;
import java.util.Map;

public class EvalVisitor extends ExprBaseVisitor<Integer> {

    private Map<String, Integer> hs = new HashMap<>();
  @Override
  public Integer visitPrintExpr(ExprParser.PrintExprContext ctx) {
    int value = visit(ctx.expr());
    System.out.println(value);
    return 0;
  }

  @Override
  public Integer visitInt(ExprParser.IntContext ctx) {
    return Integer.valueOf(ctx.INT().getText());
  }

  @Override
  public Integer visitMulDiv(ExprParser.MulDivContext ctx) {
    int left = visit(ctx.expr(0));
    int right = visit(ctx.expr(1));
    if (ctx.op.getType() == ExprParser.MUL)
      return left * right;
    else
      return left / right;
  }

  @Override
  public Integer visitAddSub(ExprParser.AddSubContext ctx) {
    int left = visit(ctx.expr(0));
    int right = visit(ctx.expr(1));
    if (ctx.op.getType() == ExprParser.ADD)
      return left + right;
    else
      return left - right;
  }

  @Override
  public Integer visitParens(ExprParser.ParensContext ctx) {
    return visit(ctx.expr());
  }

  @Override
  public Integer visitAssign(ExprParser.AssignContext ctx){
      String org = ctx.ID().getText(); 
      int value = visit(ctx.expr());
      hs.put(org, value); 
      return value;

  }

    @Override
   public Integer visitId(ExprParser.IdContext ctx) {
       String org = ctx.ID().getText; 
       int value = hs.get(org);
       if (value == 0){
           return 0;
       }
       else{
           return value; 
       }
   }
}
