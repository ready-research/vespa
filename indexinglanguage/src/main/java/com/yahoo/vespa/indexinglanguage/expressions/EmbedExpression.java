// Copyright Yahoo. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.vespa.indexinglanguage.expressions;

import com.yahoo.document.DataType;
import com.yahoo.document.TensorDataType;
import com.yahoo.document.datatypes.StringFieldValue;
import com.yahoo.document.datatypes.TensorFieldValue;
import com.yahoo.language.process.Embedder;
import com.yahoo.tensor.Tensor;
import com.yahoo.tensor.TensorType;

/**
 * Embeds a string in a tensor space using the configured Embedder component
 *
 * @author bratseth
 */
public class EmbedExpression extends Expression  {

    private final Embedder embedder;

    /** The target type we are embedding into. */
    private TensorType targetType;

    public EmbedExpression(Embedder embedder) {
        super(DataType.STRING);
        this.embedder = embedder;
    }

    @Override
    public void setStatementOutputType(DataType type) {
        targetType = ((TensorDataType)type).getTensorType();
    }

    @Override
    protected void doExecute(ExecutionContext context) {
        StringFieldValue input = (StringFieldValue) context.getValue();
        Tensor tensor = embedder.embed(input.getString(), context.getLanguage(), targetType);
        context.setValue(new TensorFieldValue(tensor));
    }

    @Override
    protected void doVerify(VerificationContext context) {
        String outputField = context.getOutputField();
        if (outputField == null)
            throw new VerificationException(this, "No output field in this statement: " +
                                                  "Don't know what tensor type to embed into.");
        DataType outputFieldType = context.getInputType(this, outputField);
        if ( ! (outputFieldType instanceof TensorDataType) )
            throw new VerificationException(this, "The type of the output field " + outputField +
                                                  " is not a tensor but " + outputField);
        targetType = ((TensorDataType) outputFieldType).getTensorType();
        context.setValueType(createdOutputType());
    }

    @Override
    public DataType createdOutputType() {
        return new TensorDataType(targetType);
    }

    @Override
    public String toString() { return "embed"; }

    @Override
    public int hashCode() { return 1; }

    @Override
    public boolean equals(Object o) { return o instanceof EmbedExpression; }

}
