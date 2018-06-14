#include <inverter.h>
#include "gtest/gtest.h"

TEST(InverterTest, TrueToFalse)
{
    EXPECT_EQ(false, invert(true));
}

TEST(InverterTest, FalseToTrue)
{
    EXPECT_EQ(true, invert(false));
}