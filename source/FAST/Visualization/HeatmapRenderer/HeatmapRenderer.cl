__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void renderToTexture(
        __global float* inputTensor,
        __write_only image2d_t output,
        __constant float* colors,
        __private float minConfidence,
        __private float maxOpacity,
        __private int channels
) {
    const int2 position = {get_global_id(0), get_global_id(1)};

    float4 color = {0.0f, 0.0f, 0.0f, 0.0f};
    // TODO blend colorsd
    for(int channel = 0; channel < channels; ++channel) {
        float intensity = inputTensor[(position.y + position.x*get_global_size(1))*channels + channel];

        if(intensity < 0.1) {
            intensity = 0;
        } else {
            intensity *= 0.3;
            float3 colorToUse = vload3(channel, colors);
            color = color + 1.0f * colorToUse.xyzz;
            color.w = 1.0f;//intensity;
            color = (float4)(1.0f, 0,0,1);
            color = clamp(color, 0.0f, 1.0f);
            //printf("%f %f %f\n", color.x, color.y, color.z);
        }
    }
    write_imagef(output, (int2)(position.x, get_image_height(output) - position.y - 1), color);
}

