package endpoint

import (
	"context"
	"fmt"
  "github.com/graniticio/granitic/ws"
	"github.com/graniticio/granitic/logging"
)

type StatusLogic struct{
	ServiceName string
	Log logging.Logger
}

func (sl *StatusLogic) Process(ctx context.Context, req *ws.WsRequest, res *ws.WsResponse) {
	sl.Log.LogInfof("Serving request")
	res.Body = fmt.Sprintf("All good from %s", sl.ServiceName)
}
