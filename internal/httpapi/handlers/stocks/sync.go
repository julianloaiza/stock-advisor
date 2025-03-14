package stocks

import (
	"net/http"
	"strconv"

	"github.com/julianloaiza/stock-advisor/internal/httpapi/handlers/response"
	"github.com/labstack/echo/v4"
)

// SyncStocks sincroniza la base de datos con la API mediante el servicio.
// Parámetro de query:
//   - limit: cantidad de iteraciones (por defecto 1)
func (h *handler) SyncStocks(c echo.Context) error {
	// Leer el parámetro "limit", por defecto 1
	limitStr := c.QueryParam("limit")
	limit := 1
	if limitStr != "" {
		parsed, err := strconv.Atoi(limitStr)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.APIResponse{
				Code:    http.StatusBadRequest,
				Error:   "Parámetro limit inválido",
				Message: "El parámetro limit debe ser un número entero",
			})
		}
		limit = parsed
	}

	// Llamada al servicio pasando el contexto y el límite
	err := h.service.SyncStocks(c.Request().Context(), limit)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.APIResponse{
			Code:    http.StatusInternalServerError,
			Error:   "Error sincronizando stocks",
			Message: err.Error(),
		})
	}

	return c.JSON(http.StatusOK, response.APIResponse{
		Code:    http.StatusOK,
		Data:    nil,
		Message: "Sincronización completada exitosamente",
	})
}
