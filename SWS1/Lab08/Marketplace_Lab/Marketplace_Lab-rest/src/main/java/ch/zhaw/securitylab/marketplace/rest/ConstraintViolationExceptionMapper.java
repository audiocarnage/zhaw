package ch.zhaw.securitylab.marketplace.rest;

import ch.zhaw.securitylab.marketplace.dto.RestErrorDto;
import java.util.Set;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class ConstraintViolationExceptionMapper implements ExceptionMapper<ConstraintViolationException> {

    @Override
    public Response toResponse(ConstraintViolationException exception) {
        RestErrorDto error = new RestErrorDto();
        Response.ResponseBuilder responseBuilder;
        Set<ConstraintViolation<?>> constraintViolations = exception.getConstraintViolations();
        StringBuilder errorMessage = new StringBuilder();
        for (ConstraintViolation<?> constraintViolation : constraintViolations) {
            if (errorMessage.length() > 0) {
                errorMessage.append(", ");
            }
            errorMessage.append(constraintViolation.getMessage());
        }
        error.setError(errorMessage.toString());
        return Response.status(Response.Status.BAD_REQUEST).entity(error).build();
    }
}
